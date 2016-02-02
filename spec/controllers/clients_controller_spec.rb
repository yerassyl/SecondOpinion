require 'rails_helper'

RSpec.describe ClientsController, :type => :controller do

  describe 'POST #accept' do

    before do
      @callback = CallBack.create(name: 'Yerassyl Diyas')
    end
    context 'success' do

      it 'gets callback id' do
        post 'clients/1/accept'
        #expect(params[:id]).to be present?
      end
      it 'finds callback with id' do

      end
      it 'creates user' do

      end
      it 'assigns role to user' do

      end
      it 'creates client' do

      end

    end

    context 'failure' do

    end

  end

end