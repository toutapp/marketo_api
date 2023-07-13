require 'spec_helper'

describe MarketoApi::Middleware::RaiseError do
  subject { MarketoApi::Middleware::RaiseError.new }

  describe "#on_complete" do
    it 'should not raise any exception' do
      expect(subject.on_complete({ :status => 200 })).to eq(nil)
    end
  end

  describe "#message" do
    it 'should return body when body has no error message' do
      subject.on_complete({
                            :status => 200,
                            :response_headers => {},
                            :body => {}
                          })
      expect(subject.message).to eq(': ')
    end

    it 'should return body when body has error message' do
      subject.on_complete({
                            :status => 200,
                            :response_headers => {},
                            :body => { 'errorCode' => '500', 'message' => 'failure' }
                          })
      expect(subject.message).to eq('500: failure')
    end
  end

  describe "#body" do
    it 'should return body when body is array and first element is hash' do
      subject.on_complete({
                            :status => 200,
                            :response_headers => {},
                            :body => [{ :result => 'success' }]
                          })
      expect(subject.body).to eq({ :result => 'success' })
    end

    it 'should return body when body is hash' do
      subject.on_complete({
                            :status => 200,
                            :response_headers => {},
                            :body => { :result => 'success' }
                          })
      expect(subject.body).to eq({ :result => 'success' })
    end

    it 'should return body when body is not hash' do
      subject.on_complete({ :status => 200, :response_headers => {}, :body => 'failure' })
      expect(subject.body).to eq({ 'errorCode' => '(error code missing)', 'message' => 'failure' })
    end
  end

  describe "#response_values" do
    it 'should return status and headers and body' do
      subject.on_complete({ :status => 200, :response_headers => {}, :body => [] })
      expect(subject.response_values).to eq({ :status => 200, :headers => {}, :body => [] })
    end

    it 'should return empty status and headers and body' do
      subject.on_complete({})
      expect(subject.response_values).to eq({ :status => nil, :headers => nil, :body => nil })
    end
  end
end
