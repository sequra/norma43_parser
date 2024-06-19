# frozen_string_literal: true

RSpec.shared_examples "a model" do
  it { is_expected.to respond_to(:attributes) }
  it { is_expected.to respond_to(:attributes=) }
  it { is_expected.to respond_to(:to_h) }
  it { is_expected.to respond_to(:to_hash) }

  describe "#new" do
    subject(:model) { described_class.new(attributes) }

    context "when instantiated with an empty hash" do
      let(:attributes) { {} }

      it "accepts it without failing" do
        expect { model }.not_to raise_error
      end
    end
  end

  describe "#attributes" do
    subject { described_class.new.attributes }

    it { is_expected.not_to be_empty }
    it { is_expected.to respond_to(:each_pair) }
    it { is_expected.to respond_to(:to_h) }
    it { is_expected.to respond_to(:to_hash) }
    it { is_expected.to respond_to(:keys) }

    describe "#attributes.keys" do
      subject { super().keys }

      it { is_expected.not_to be_empty }
      it { is_expected.to all(be_a(Symbol)) }
    end
  end

  describe "#attributes=" do
    subject { described_class.new.attributes=(attributes) }

    context "when passed an empty hash" do
      let(:attributes) { {} }

      it "accepts it without failing" do
        expect { subject }.not_to raise_error
      end
    end

    context "when passed a hash with unknown attribute names" do
      let(:attributes) { { potato: nil } }

      it "accepts it without failing" do
        expect { subject }.not_to raise_error
      end

      it "does not set any new method" do
        expect { subject.potato }.to raise_error(NoMethodError, /undefined method.+potato/i)
      end
    end
  end
end
