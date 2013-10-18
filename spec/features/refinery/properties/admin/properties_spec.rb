# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Properties" do
    describe "Admin" do
      describe "properties" do
        refinery_login_with :refinery_user

        describe "properties list" do
          before do
            FactoryGirl.create(:property, :region => "UniqueTitleOne")
            FactoryGirl.create(:property, :region => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.properties_admin_properties_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before do
            visit refinery.properties_admin_properties_path

            click_link "Add New Property"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Region", :with => "This is a test of the first string field"
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::Properties::Property.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Region can't be blank")
              Refinery::Properties::Property.count.should == 0
            end
          end

          context "duplicate" do
            before { FactoryGirl.create(:property, :region => "UniqueTitle") }

            it "should fail" do
              visit refinery.properties_admin_properties_path

              click_link "Add New Property"

              fill_in "Region", :with => "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::Properties::Property.count.should == 1
            end
          end

        end

        describe "edit" do
          before { FactoryGirl.create(:property, :region => "A region") }

          it "should succeed" do
            visit refinery.properties_admin_properties_path

            within ".actions" do
              click_link "Edit this property"
            end

            fill_in "Region", :with => "A different region"
            click_button "Save"

            page.should have_content("'A different region' was successfully updated.")
            page.should have_no_content("A region")
          end
        end

        describe "destroy" do
          before { FactoryGirl.create(:property, :region => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.properties_admin_properties_path

            click_link "Remove this property forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::Properties::Property.count.should == 0
          end
        end

      end
    end
  end
end
