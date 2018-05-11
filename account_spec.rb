require "rspec"
require_relative "account"

describe Account do

  let(:acct_number) {"1010121211"}
  let(:starting_balance) {2}
  let(:account) {Account.new(acct_number, starting_balance)}
  let(:transactions) {[ starting_balance ]}

  describe "#initialize" do
    context "with valid input" do
      it "creates a bank account with number and an array of transactions beginning with starting balance" do
        
        expect(account.balance).to eq(2)
      end
    end

    context "with an invalid account number" do
      it "raises invalid account number error" do
        expect{Account.new("101012121", 1)}.to raise_error(InvalidAccountNumberError)
      end
    end

    context "without arguments" do
      it 'throws an argument error without account number or starting balance'  do
        expect{Account.new}.to raise_error(ArgumentError)
      end
    end
  end

  describe "#transactions" do
    it "returns the transactions of an account" do
      expect(account.transactions).to eq(transactions)
    end
  end

  describe "#balance" do
    it "returns the sum of all transactions" do
      expect(account.balance).to eq(transactions.inject(:+))
    end
  end

  describe "#acct_number" do
    it "it returns account number, with some numbers hidden" do
      hidden_length = acct_number.length - 4
      expect(account.acct_number).to eq(acct_number.sub(Regexp.new("^.{#{hidden_length}}"), "*" * hidden_length))
    end
  end

  describe "deposit!" do
    context "with valid input" do
      it "adds a value to transactions and changes the value of balance" do
        expect{account.deposit!(10)}.to change(account, :transactions)
      end
    end

    context  "with invalid input, deposit a negative or 0 number" do
      it "will raise a negative deposit error" do
        expect{account.deposit!(-1)}.to raise_error(NegativeDepositError)
      end
    end
  end


  describe "withdraw!" do
    context "with valid input" do
      it "adds a negative value(not to exceed balance) to transactions and changes the value of balance" do
        expect{account.withdraw!(1)}.to change(account, :transactions)
      end
    end

    context "with invalid input (exceed balance)" do
      it "will raise a negative deposit error" do
        expect{account.withdraw!(3)}.to raise_error(OverdraftError)
      end
    end
  end



end