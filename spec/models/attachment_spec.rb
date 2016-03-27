require "acceptance/rails.spec"

  describe Attachment do
    it {should belong_to question}
  end