require 'test_helper'

module Jekyll
  module Invoice
    describe Invoice do
      let(:invoice) { Invoice.new }

      describe 'daily_rate' do
        it 'should set the prevailing daily payment rate' do
          invoice.process <<-EOI
            daily_rate 600
          EOI
          invoice.daily_rate.must_equal 600
        end
      end

      describe 'hourly_rate' do
        it 'should set the prevailing hourly payment rate' do
          invoice.process <<-EOI
            hourly_rate 60
          EOI
          invoice.hourly_rate.must_equal 60
        end
      end

      describe 'line' do
        it 'should add a line to the invoice' do
          invoice.lines.size.must_equal 0
          invoice.process <<-EOI
            line 'Do some work'
          EOI
          invoice.lines.size.must_equal 1
        end

        it 'should add lines in order' do
          invoice.lines.size.must_equal 0
          invoice.process <<-EOI
            line 'Do some work'
            line 'More work'
          EOI
          invoice.lines.size.must_equal 2
          invoice.lines.map(&:description) \
            .must_equal ['Do some work', 'More work']
        end
      end
    end
  end
end
