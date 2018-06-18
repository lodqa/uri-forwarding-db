Matcher.delete_all
Matcher.create([{
                 uri_pattern: 'http://www4.wiwiss.fu-berlin.de/diseasome/resource/genes/(?<entry>.+)',
                 url_replacement_pattern: 'http://www.genecards.org/cgi-bin/carddisp.pl?gene=\k<entry>',
                 xpath_to_media: '//*[@id="genomic_location"]/div[2]/div[4]/div/figure/img',
                 name: 'GeneCards',
                 priority: 2
               }, {
                 uri_pattern: '(?<uri>http://www4.wiwiss.fu-berlin.de/diseasome/resource/genes/.+)',
                 url_replacement_pattern: 'http://rdf.pubannotation.org/sparql?format=application%2Fx-nice-microdata&query=describe+%3C\k<uri>%3E',
                 name: 'Describe',
                 priority: 0
               }, {
                 uri_pattern: '(?<uri>http://www4.wiwiss.fu-berlin.de/diseasome/resource/diseases/.+)',
                 url_replacement_pattern: 'http://rdf.pubannotation.org/sparql?format=application%2Fx-nice-microdata&query=describe+%3C\k<uri>%3E',
                 name: 'Describe',
                 priority: 0
               }, {
                 uri_pattern: 'http://www4.wiwiss.fu-berlin.de/diseasome/resource/genes/(?<entry>.+)',
                 url_replacement_pattern: 'https://ghr.nlm.nih.gov/gene/\k<entry>',
                 xpath_to_media: '//*[@id="location"]/div/div/div/div[1]/div[1]/span/span/img',
                 name: 'GHR',
                 priority: -2
               }, {
                 uri_pattern: 'http://www4.wiwiss.fu-berlin.de/diseasome/resource/genes/(?<entry>.+)',
                 url_replacement_pattern: 'http://togogenome.org/gene/9606:\k<entry>',
                 url_replacement_pattern_for_media: 'http://togostanza.org/stanza/protein_3d_structure_nano?gene_id=\k<entry>&tax_id=9606',
                 xpath_to_media: '//*[@id="main-view"]/img',
                 name: 'TogoGenome',
                 priority: 4
               }, {
                 uri_pattern: 'http://purl.jp/bio/101/opentggates/ChemicalCompound/(?<entry>.+)',
                 url_replacement_pattern: 'http://toxico.nibiohn.go.jp/open-tggates/compound_search/screen2/compound?compound_id=\k<entry>',
                 name: 'Open TG-GATEs',
                 priority: 0
               }, {
                 uri_pattern: 'http://bio2rdf.org/omim:(?<entry>.+)',
                 url_replacement_pattern: 'https://www.omim.org/entry/\k<entry>',
                 name: 'OMIM',
                 priority: 0
               }, {
                 uri_pattern: 'http://www4.wiwiss.fu-berlin.de/sider/resource/side_effects/(?<entry>.+)',
                 url_replacement_pattern: 'http://sideeffects.embl.de/se/\k<entry>',
                 name: 'SIDER',
                 priority:	1
               }, {
                 uri_pattern: 'http://www4.wiwiss.fu-berlin.de/sider/resource/side_effects/(?<entry>.+)',
                 url_replacement_pattern: 'https://www.ncbi.nlm.nih.gov/medgen/\k<entry>',
                 name: 'MedGen',
                 priority:	0
               }, {
                 uri_pattern: 'http://www4.wiwiss.fu-berlin.de/sider/resource/drugs/(?<entry>.+)',
                 url_replacement_pattern: 'http://sideeffects.embl.de/drugs/\k<entry>',
                 xpath_to_media: '//*[@id="drugInfoMain"]/div[1]/div[1]/img',
                 name: 'SIDER',
                 priority:	1
               }, {
                 uri_pattern: 'http://www4.wiwiss.fu-berlin.de/sider/resource/side_effects/(?<entry>.+)',
                 url_replacement_pattern: 'https://pubchem.ncbi.nlm.nih.gov/compound/\k<entry>',
                 xpath_to_media: '//*[@id="2D-Structure"]/div[2]/div[1]/div/img',
                 name: 'PubChem',
                 priority: 0
               }, {
                 uri_pattern: 'http://bio2rdf.org/drugbank:(?<entry>.+)',
                 url_replacement_pattern: 'https://www.drugbank.ca/drugs/\k<entry>',
                 xpath_to_media: '/html/body/main/div/div[4]/dl[1]/dd[6]/div[1]/a/img',
                 name: 'DrugBank',
                 priority: 0
               }])
