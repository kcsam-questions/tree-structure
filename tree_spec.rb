require "byebug"
require "yaml"
require_relative "tree"

describe 'Program' do
  let(:tree_structure) do
    path = File.join(File.join(__dir__, 'tree_structure.yml'))
    YAML.load_file(path)
  end

  describe TreeNode do
    describe '.as_array' do
      it 'yields items in an array' do
        node = TreeNode.new(tree_structure)

        array = ['MyDocuments',
                 ['2016_financial_projection.xlsx'],
                 ['new_document1.docx'],
                 ['Workspace',
                  ['LawReports',
                   ['SLA_0001.pdf'],
                   ['SLA_0002.pdf'],
                   ['SLA_0003.pdf'],
                   ['SLA_0004.pdf']],
                  ['Contracts',
                   ['InformationTechnology',
                    ['IBM',
                     ['Equipments',
                      ['Laptops',
                       ['Pre2016_Models',
                        ['LN3002.pdf'],
                        ['LN3003.pdf'],
                        ['LN3010.pdf'],
                        ['LN6010.pdf']],
                       ['2016_Models', ['LN9020.pdf']]]]],
                    ['AWS', ['EnterpriseAgreement2014_2015.pdf']]],
                   ['Marketing',
                    ['Advox', ['2013_campaign.pdf'], ['2013_campaign_signed.pdf']]]],
                  ['Circular', ['CC2201.pdf'], ['CC2301.pdf'], ['CC2308.pdf']],
                  ['Drafts', ['AmexPartnership_Draft.docx'], ['VisaPartnership_Draft.docx']]]]
        expect(node.as_array.to_s).to eq(array.to_s)
      end
    end

    describe '.as_ordered_list' do
      it 'yields items in ordered list' do
        node = TreeNode.new(tree_structure)

        list = %w[
          MyDocuments
          2016_financial_projection.xlsx
          new_document1.docx
          Workspace
          LawReports
          SLA_0001.pdf
          SLA_0002.pdf
          SLA_0003.pdf
          SLA_0004.pdf
          Contracts
          InformationTechnology
          IBM
          Equipments
          Laptops
          Pre2016_Models
          LN3002.pdf
          LN3003.pdf
          LN3010.pdf
          LN6010.pdf
          2016_Models
          LN9020.pdf
          AWS
          EnterpriseAgreement2014_2015.pdf
          Marketing
          Advox
          2013_campaign.pdf
          2013_campaign_signed.pdf
          Circular
          CC2201.pdf
          CC2301.pdf
          CC2308.pdf
          Drafts
          AmexPartnership_Draft.docx
          VisaPartnership_Draft.docx
        ]
        expect(node.as_ordered_list.to_s).to eq(list.to_s)
      end
    end

    describe '.as_paths' do
      it 'yields items in path format' do
        node = TreeNode.new(tree_structure)

        paths = %w[
          MyDocuments
          MyDocuments/2016_financial_projection.xlsx
          MyDocuments/new_document1.docx
          MyDocuments/Workspace
          MyDocuments/Workspace/LawReports
          MyDocuments/Workspace/LawReports/SLA_0001.pdf
          MyDocuments/Workspace/LawReports/SLA_0002.pdf
          MyDocuments/Workspace/LawReports/SLA_0003.pdf
          MyDocuments/Workspace/LawReports/SLA_0004.pdf
          MyDocuments/Workspace/Contracts
          MyDocuments/Workspace/Contracts/InformationTechnology
          MyDocuments/Workspace/Contracts/InformationTechnology/IBM
          MyDocuments/Workspace/Contracts/InformationTechnology/IBM/Equipments
          MyDocuments/Workspace/Contracts/InformationTechnology/IBM/Equipments/Laptops
          MyDocuments/Workspace/Contracts/InformationTechnology/IBM/Equipments/Laptops/Pre2016_Models
          MyDocuments/Workspace/Contracts/InformationTechnology/IBM/Equipments/Laptops/Pre2016_Models/LN3002.pdf
          MyDocuments/Workspace/Contracts/InformationTechnology/IBM/Equipments/Laptops/Pre2016_Models/LN3003.pdf
          MyDocuments/Workspace/Contracts/InformationTechnology/IBM/Equipments/Laptops/Pre2016_Models/LN3010.pdf
          MyDocuments/Workspace/Contracts/InformationTechnology/IBM/Equipments/Laptops/Pre2016_Models/LN6010.pdf
          MyDocuments/Workspace/Contracts/InformationTechnology/IBM/Equipments/Laptops/2016_Models
          MyDocuments/Workspace/Contracts/InformationTechnology/IBM/Equipments/Laptops/2016_Models/LN9020.pdf
          MyDocuments/Workspace/Contracts/InformationTechnology/AWS
          MyDocuments/Workspace/Contracts/InformationTechnology/AWS/EnterpriseAgreement2014_2015.pdf
          MyDocuments/Workspace/Contracts/Marketing
          MyDocuments/Workspace/Contracts/Marketing/Advox
          MyDocuments/Workspace/Contracts/Marketing/Advox/2013_campaign.pdf
          MyDocuments/Workspace/Contracts/Marketing/Advox/2013_campaign_signed.pdf
          MyDocuments/Workspace/Circular
          MyDocuments/Workspace/Circular/CC2201.pdf
          MyDocuments/Workspace/Circular/CC2301.pdf
          MyDocuments/Workspace/Circular/CC2308.pdf
          MyDocuments/Workspace/Drafts
          MyDocuments/Workspace/Drafts/AmexPartnership_Draft.docx
          MyDocuments/Workspace/Drafts/VisaPartnership_Draft.docx
        ]
        expect(node.as_paths.to_s).to eq(paths.to_s)
      end
    end

    describe '.select_files' do
      it 'yields items in path format' do
        node = TreeNode.new(tree_structure)

        files = %w[
          2016_financial_projection.xlsx
          new_document1.docx
          SLA_0001.pdf
          SLA_0002.pdf
          SLA_0003.pdf
          SLA_0004.pdf
          LN3002.pdf
          LN3003.pdf
          LN3010.pdf
          LN6010.pdf
          LN9020.pdf
          EnterpriseAgreement2014_2015.pdf
          2013_campaign.pdf
          2013_campaign_signed.pdf
          CC2201.pdf
          CC2301.pdf
          CC2308.pdf
          AmexPartnership_Draft.docx
          VisaPartnership_Draft.docx
        ]
        expect(node.select_files.to_s).to eq(files.to_s)
      end
    end

    describe '.as_ordered_list_with_depth' do
      it 'yields items in array together with depth' do
        node = TreeNode.new(tree_structure)

        list = [['MyDocuments', 1],
                ['2016_financial_projection.xlsx', 2],
                ['new_document1.docx', 2],
                ['Workspace', 2],
                ['LawReports', 3],
                ['SLA_0001.pdf', 4],
                ['SLA_0002.pdf', 4],
                ['SLA_0003.pdf', 4],
                ['SLA_0004.pdf', 4],
                ['Contracts', 3],
                ['InformationTechnology', 4],
                ['IBM', 5],
                ['Equipments', 6],
                ['Laptops', 7],
                ['Pre2016_Models', 8],
                ['LN3002.pdf', 9],
                ['LN3003.pdf', 9],
                ['LN3010.pdf', 9],
                ['LN6010.pdf', 9],
                ['2016_Models', 8],
                ['LN9020.pdf', 9],
                ['AWS', 5],
                ['EnterpriseAgreement2014_2015.pdf', 6],
                ['Marketing', 4],
                ['Advox', 5],
                ['2013_campaign.pdf', 6],
                ['2013_campaign_signed.pdf', 6],
                ['Circular', 3],
                ['CC2201.pdf', 4],
                ['CC2301.pdf', 4],
                ['CC2308.pdf', 4],
                ['Drafts', 3],
                ['AmexPartnership_Draft.docx', 4],
                ['VisaPartnership_Draft.docx', 4]]
        expect(node.as_ordered_list_with_depth.to_s).to eq(list.to_s)
      end
    end

    describe '.as_depth_first_paths' do
      it 'yields Depth-First paths' do
        node = TreeNode.new(tree_structure)

        df_paths = %w[
                    MyDocuments/Workspace/Contracts/InformationTechnology/IBM/Equipments/Laptops/2016_Models/LN9020.pdf
                    MyDocuments/Workspace/Contracts/InformationTechnology/IBM/Equipments/Laptops/Pre2016_Models/LN3010.pdf
                    MyDocuments/Workspace/Contracts/InformationTechnology/IBM/Equipments/Laptops/Pre2016_Models/LN3003.pdf
                    MyDocuments/Workspace/Contracts/InformationTechnology/IBM/Equipments/Laptops/Pre2016_Models/LN3002.pdf
                    MyDocuments/Workspace/Contracts/InformationTechnology/IBM/Equipments/Laptops/Pre2016_Models/LN6010.pdf
                    MyDocuments/Workspace/Contracts/InformationTechnology/IBM/Equipments/Laptops/Pre2016_Models
                    MyDocuments/Workspace/Contracts/InformationTechnology/IBM/Equipments/Laptops/2016_Models
                    MyDocuments/Workspace/Contracts/InformationTechnology/IBM/Equipments/Laptops
                    MyDocuments/Workspace/Contracts/InformationTechnology/IBM/Equipments
                    MyDocuments/Workspace/Contracts/InformationTechnology/AWS/EnterpriseAgreement2014_2015.pdf
                    MyDocuments/Workspace/Contracts/Marketing/Advox/2013_campaign_signed.pdf
                    MyDocuments/Workspace/Contracts/Marketing/Advox/2013_campaign.pdf
                    MyDocuments/Workspace/Contracts/InformationTechnology/IBM
                    MyDocuments/Workspace/Contracts/Marketing/Advox
                    MyDocuments/Workspace/Contracts/InformationTechnology/AWS
                    MyDocuments/Workspace/Drafts/AmexPartnership_Draft.docx
                    MyDocuments/Workspace/Circular/CC2308.pdf
                    MyDocuments/Workspace/Circular/CC2301.pdf
                    MyDocuments/Workspace/Circular/CC2201.pdf
                    MyDocuments/Workspace/Contracts/Marketing
                    MyDocuments/Workspace/Contracts/InformationTechnology
                    MyDocuments/Workspace/LawReports/SLA_0004.pdf
                    MyDocuments/Workspace/LawReports/SLA_0003.pdf
                    MyDocuments/Workspace/LawReports/SLA_0002.pdf
                    MyDocuments/Workspace/LawReports/SLA_0001.pdf
                    MyDocuments/Workspace/Drafts/VisaPartnership_Draft.docx
                    MyDocuments/Workspace/Circular
                    MyDocuments/Workspace/LawReports
                    MyDocuments/Workspace/Contracts
                    MyDocuments/Workspace/Drafts
                    MyDocuments/Workspace
                    MyDocuments/new_document1.docx
                    MyDocuments/2016_financial_projection.xlsx
                    MyDocuments
        ]
        expect(node.as_depth_first_paths.to_s).to eq(df_paths.to_s)
      end
    end
  end
end
