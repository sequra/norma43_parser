module Norma43
  class InvalidFileFormatError < ArgumentError; end

  class Parser
    attr_reader :file

    # Parser.new accepts a File instance or a String
    # A InvalidFileFormatError will be raised if file isn't in the Norma43 format
    def initialize(file)
      @file = file
      validator = validate_file_format
      @contexts = if validator.has_document?
        Norma43::Utils::Contexts.new
      else
        # in theory Norma43 says that files should start with DocumentStart but
        # practically doesn't happen, so that we create one artificially
        # to avoid corner cases in the processors
        Norma43::Utils::Contexts.new().tap { |ctx| ctx.add Models::Document.new }
      end
    end

    def result
      parse_lines(@contexts).result
    end

    protected

    def lines
      @lines ||= file.each_line
    end

    private

    def validate_file_format
      validator = Norma43::LineParsers::FileFormatValidator.new first_line
      raise InvalidFileFormatError.new(validator.errors.join(", ")) unless validator.valid?
      validator
    end

    def parse_lines(contexts)
      parse_lines parse_line(self.lines.next, contexts)

    rescue StopIteration # because lines is an enumerator raises StopIteration on end
      self.lines.rewind # Ensure we do not bomb out when calling result multiple times
      contexts
    end

    # Look up a matching handler for the line and process it
    # The process method on a handler always returns a Contexts object
    def parse_line(line, contexts)
      line = line.encode Encoding::UTF_8 if encode_lines?

      handler = handler_for_line line

      handler.process line, contexts
    end

    def handler_for_line(line)
      LineHandlers.mapping.fetch line[0..1]
    end

    def encode_lines?
      first_line.encoding != Encoding::UTF_8
    end

    def first_line
      @first_line ||= begin
        line = self.lines.peek
        self.lines.rewind # peek seems to move the pointer when file is an actual File object

        line
      end
    end
  end
end
