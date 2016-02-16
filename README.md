# Norma43 file parser

Norma43 is the standard format file to extract bank transactions from the SEPA (Single euro payments area), format details and content is described in the [Norma43 format](https://github.com/sequra/norma43_parser/blob/master/doc/cuaderno_43_-_junio_2012.pdf). 

## Usage

Include it in your Gemfile
```
gem 'norma43_parser', git: "git@github.com:sequra/norma43_parser.git"
```


```ruby
require "norma43"

norma43_file_contents = File.open("path_to_file.n43", encoding: "iso-8859-1")
document = norma43.parse norma43_file_contents
```

### Document

The parser returns a Norma43 Document that may include multiple accounts.

```
accounts=[account1..accountN]
```

### Account 

The account object has all the information described in the standard format and the transactions between **start_date** and **end_date**.

```
abbreviated_name="ACCOUNT NAME",
account_number=1234567,
balance_amount=504585,
balance_code=2,
bank_code=81,
branch_code=54,
credit_amount=254785,
credit_entries=45,
currency_code=978,
debit_amount=0,
debit_entries=0,
start_date=Tue, 04 Feb 2016,
end_date=Tue, 04 Feb 2016,
information_mode_code=3,
transactions=[transaction1..transactionN]
```

### Transaction

The transaction object has all the information described in the standard format and may include a maximum of five additional items.

```
additional_currency=nil,
amount=3206,
amount_code=2,
document_number=0,
origin_branch_code=123,
own_item=16,
reference_1=0,
reference_2=nil,
shared_item=4,
transaction_date=Tue, 04 Feb 2016,
value_date=Tue, 04 Feb 2016,
additional_items=[additional_item1..aditional_item5]
```

### Additional items

The additional item object has an identifier and two free text fields that may include or not relevant information

```
data_code=1,
item_1="TRANSFERENC. ANTONIO JOSE GARCIA MARTI",
item_2="NEZ"
```

## Contributing

1. Fork it ( https://github.com/sequra/norma43_parser.git )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
