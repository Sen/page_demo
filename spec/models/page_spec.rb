require 'spec_helper'

describe Page do

  describe 'validation' do

    it 'title, content, presence' do
      [:title, :content].each do |attr|
        page = build(:page)
        page.send("#{attr}=", nil)
        page.valid?.should be_false
        page.errors[attr].any?.should be_true
      end
    end

    it "title unique" do
      exists_page = create(:page)
      page = build(:page, title: exists_page.title)
      page.valid?.should be_false
      page.errors[:title].any?.should be_true
    end

  end

  it 'words' do
    page = create(:page, title: 'a bb ccc dddd', content: 'e ff gg')
    page.count_words.should == 7
  end

  it "publish" do
    page = create(:page)
    page.published_on?.should be_false
    page.publish
    page.reload
    page.published_on?.should be_true
  end

  it "published and unpublished scope" do
    page_1 = create(:page)
    page_2 = create(:page)
    page_2.publish
    Page.published.should == [page_2]
    Page.unpublished.should == [page_1]
  end

end
