s:license: "https://www.apache.org/licenses/LICENSE-2.0"
s:copyrightHolder: "EMBL - European Bioinformatics Institute"
class: CommandLineTool
id: file:///F:/Thesis/ExampleWorkflow/tools/mapseq2biom/mapseq2biom.cwl
inputs:
- id: label
  label: label to add to the top of the outfile OTU table
  inputBinding:
    prefix: --label
  type: string
- id: otu_table
  doc: |
    the OTU table produced for the taxonomies found in the reference
    databases that was used with MAPseq
  inputBinding:
    prefix: --otuTable
  type: File
- id: query
  label: the output from the MAPseq that assigns a taxonomy to a sequence
  inputBinding:
    prefix: --query
  type: File
- id: taxid_flag
  label: output NCBI taxids for all databases bar UNITE
  inputBinding:
    prefix: --taxid
  type:
  - 'null'
  - boolean
outputs:
- id: otu_tsv
  outputBinding:
    glob: $(inputs.query.basename).tsv
  format: http://edamontology.org/format_3746
  type: File
- id: otu_tsv_notaxid
  outputBinding:
    glob: $(inputs.query.basename).notaxid.tsv
  format: http://edamontology.org/format_3746
  type:
  - 'null'
  - File
- id: otu_txt
  outputBinding:
    glob: $(inputs.query.basename).txt
  format: https://www.iana.org/assignments/media-types/text/tab-separated-values
  type: File
requirements:
- class: ResourceRequirement
  coresMin: 2
  ramMin: 200
  tmpdirMin: 200
- class: DockerRequirement
  dockerPull: aeolic/cwl-wrapper:2.7.9
  dockerOutputDirectory: /app/output
- class: InitialWorkDirRequirement
  listing:
  - entryname: config.json
    entry: |-
      {
          "environmentId": "ba929bf1-a1e2-498c-bee3-187778f5ecf8",
          "outputFolder": "/output",
          "initialWorkDirRequirements": []
      }
hints: []
cwlVersion: v1.0
baseCommand:
- python3
- /app/wrapper.py
- mapseq2biom.pl
arguments:
- prefix: --outfile
  valueFrom: $(inputs.query.basename).tsv
- prefix: --krona
  valueFrom: $(inputs.query.basename).txt
$namespaces:
  edam: http://edamontology.org/
  iana: https://www.iana.org/assignments/media-types/
  s: http://schema.org/
$schemas:
- http://edamontology.org/EDAM_1.16.owl
- https://schema.org/version/latest/schemaorg-current-http.rdf

