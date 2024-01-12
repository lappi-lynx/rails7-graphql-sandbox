require 'rails_helper'

RSpec.describe 'Factories' do
  FactoryBot.factories.each do |factory|
    context "with factory for :#{factory.name}" do
      it 'is valid' do
        record = build_stubbed(factory.name)
        expect(record).to be_valid, -> { record.errors.full_messages.join("\n") }
      end

      factory.definition.defined_traits.map(&:name).each do |trait|
        context "with trait :#{trait}" do
          it 'is valid' do
            record = build_stubbed(factory.name, trait)
            expect(record).to be_valid, -> { record.errors.full_messages.join("\n") }
          end
        end
      end
    end
  end
end
