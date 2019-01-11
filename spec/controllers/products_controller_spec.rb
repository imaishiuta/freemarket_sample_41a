require 'rails_helper'

describe ProductsController do
  describe 'GET #index' do
    it "＃indexのviewを表示" do
      get :index
      expect(response).to render_template :index
    end

    it "カテゴリーレディースに属する商品が格納出来るか" do
      product = create(:product,category_id: 170)
      get :index
      expect(assigns(:ladies).length).to eq 1
    end

    it "カテゴリーメンズに属する商品が格納されるか" do
      product = create(:product,category_id: 340)
      get :index
      expect(assigns(:mens).length).to eq 1
    end

    it "カテゴリーベビー・キッズに属する商品が格納されるか" do
      product = create(:product,category_id: 397)
      get :index
      expect(assigns(:baby_products).length).to eq 1
    end

    it "カテゴリーインテリアに属する商品が格納されるか" do
      product = create(:product,category_id: 533)
      get :index
      expect(assigns(:interior_products).length).to eq 1
    end
  end

  describe 'GET #show' do
    it "要求されたproductを@productsに格納できるか" do
      product = create(:product,category_id: 340)
      get :show, params: { id: product}
      expect(assigns(:product)).to eq product
    end

    it "#showのviewを表示" do
      product = create(:product,category_id: 340)
      get :show, params: { id: product}
      expect(response).to render_template :show
    end
  end

  describe 'GET #search' do

    it "#searchのビューの表示" do
      get :search,params: {keyword: "テ"}
      expect(response).to render_template :search
    end

    it "検索フォームから送信されたキーワードで検索できるか" do
      create(:product,category_id: 340)
      get :search, params: {keyword: "テ" }
      expect(assigns(:products).length).to eq 1
    end
  end


  describe 'DELETE #destroy' do
    it "商品消去" do
      product = create(:product,category_id: 340)
      expect do
        delete :destroy, params: { id: product}
      end.to change(Product, :count).by(-1)
    end
    it "商品消去と同時に紐づく商品画像も消去できる" do
      product = create(:product,category_id: 340)
      image = create(:product_image,product_id: product.id)
      expect do
        delete :destroy, params: { id: product}
      end.to change(ProductImage, :count).by(-1)
    end
  end
end
