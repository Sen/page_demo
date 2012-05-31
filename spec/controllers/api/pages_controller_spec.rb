require 'spec_helper'

describe Api::PagesController do

  let!(:page) { create(:page) }

  before do
    @time_now = Time.now
    Time.stub!(:now).and_return(@time_now)
  end

  after do
    Page.delete_all
  end

  it "index" do
    get :index, format: :json
    response.should be_success
    get :index, format: :xml
    response.should be_success
  end

  it "index(with data)" do
    get :index, format: :json
    response.should be_success
    response.body.should == Page.all.to_json
    get :index, format: :xml
    response.should be_success
    response.body.should == Page.all.to_xml
  end

  it "show" do
    get :show, id: page.id, format: :json
    response.should be_success
    response.body.should == page.to_json
    get :show, id: page.id, format: :xml
    response.should be_success
    response.body.should == page.to_xml
  end

  it "new" do
    get :new, format: :json
    response.should be_success
    response.body.should == Page.new.to_json
    get :new, format: :xml
    response.should be_success
    response.body.should == Page.new.to_xml
  end

  it "create" do
    post :create, page: { title: 'test_title', content: 'test_content' }, format: :json
    response.should be_success
    response.body.should == assigns(:page).to_json
    assigns(:page).title.should == 'test_title'
    Page.delete_all
    post :create, page: { title: 'test_title', content: 'test_content' }, format: :xml
    response.should be_success
    response.body.should == assigns(:page).to_xml
    assigns(:page).title.should == 'test_title'
  end

  it "create(failed)" do
    post :create, page: { }, format: :json
    response.body.should == assigns(:page).errors.to_json
    post :create, page: { }, format: :xml
    response.body.should == assigns(:page).errors.to_xml
  end

  it "update" do
    put :update, id: page.id, page: { title: 'json_new_title' }, format: :json
    response.should be_success
    assigns(:page).title.should == 'json_new_title'
    Page.last.title == 'json_new_title'
    put :update, id: page.id, page: { title: 'xml_new_title' }, format: :json
    response.should be_success
    assigns(:page).title.should == 'xml_new_title'
    Page.last.title == 'xml_new_title'
  end

  it "update failed" do
    put :update, id: page.id, page: { title: '' }, format: :json
    response.body.should == assigns(:page).errors.to_json
    put :update, id: page.id, page: { title: '' }, format: :xml
    response.body.should == assigns(:page).errors.to_xml
  end

  it "destroy" do
    delete :destroy, id: page.id, format: :json
    response.should be_success
    Page.count.should == 0
    page = create(:page)
    delete :destroy, id: page.id, format: :xml
    response.should be_success
    Page.count.should == 0
  end

  it "published and unpublished" do
    Page.delete_all
    page_1 = create(:page)
    page_2 = create(:page, published_on: Time.now)

    get :published, format: :json
    response.should be_success
    response.body.should == [page_2].to_json
    get :published, format: :xml
    response.should be_success
    response.body.should == [page_2].to_xml

    get :unpublished, format: :json
    response.should be_success
    response.body.should == [page_1].to_json
    get :unpublished, format: :xml
    response.should be_success
    response.body.should == [page_1].to_xml
  end

  it "publish" do
    Page.last.published_on?.should be_false
    post :publish, id: page.id, format: :json
    response.should be_success
    page.reload
    page.published_on?.should be_true
  end

  it "total_words" do
    custom_page = create(:page, title: 'aaaa bbb ccc', content: 'ddd eee')
    get :total_words, id: custom_page.id, format: :json
    response.should be_success
    response.body.should == '5'
  end
end
