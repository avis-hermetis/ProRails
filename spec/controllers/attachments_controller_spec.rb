require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:question) { create(:question, user: user) }
  let!(:file) {create(:attachment, attachable: question)}

  describe 'DELETE #destroy' do

    context 'As not authorized user' do

      it 'failes to delete attachment' do
        expect { delete :destroy, id: file, format: :js }.to_not change(Attachment, :count)
      end
    end

    context 'As an authorized user, but not the author of question' do
      before {sign_in other_user}

      it 'fails to delete attachment' do
        expect { delete :destroy, id: file, format: :js }.to_not change(Attachment, :count)
      end
    end

    context 'As an authenticated user and the author of question' do
      before {sign_in user}

      it 'is able to delete attachment' do
        expect { delete :destroy, id: file, format: :js }.to change(Attachment, :count).by(-1)
      end

    end

  end

end