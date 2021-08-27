{
    "$graph": [
        {
            "class": "CommandLineTool",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                },
                {
                    "ramMin": 300,
                    "class": "ResourceRequirement"
                }
            ],
            "hints": [
                {
                    "dockerPull": "quay.io/biocontainers/biom-format:2.1.6--py36_0",
                    "class": "DockerRequirement"
                }
            ],
            "baseCommand": [
                "biom",
                "convert"
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "format": "http://edamontology.org/format_3746",
                    "inputBinding": {
                        "prefix": "--input-fp"
                    },
                    "id": "#biom-convert.cwl/biom"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "label": "Output as HDF5-formatted table.",
                    "inputBinding": {
                        "prefix": "--to-hdf5"
                    },
                    "id": "#biom-convert.cwl/hdf5"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "doc": "The observation metadata to include from the input BIOM table file when\ncreating a tsv table file. By default no observation metadata will be\nincluded.\n",
                    "inputBinding": {
                        "prefix": "--header-key"
                    },
                    "id": "#biom-convert.cwl/header_key"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "label": "Output as JSON-formatted table.",
                    "inputBinding": {
                        "prefix": "--to-json"
                    },
                    "id": "#biom-convert.cwl/json"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "inputBinding": {
                        "prefix": "--table-type",
                        "separate": true,
                        "valueFrom": "$(inputs.table_type)"
                    },
                    "id": "#biom-convert.cwl/table_type"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "label": "Output as TSV-formatted (classic) table.",
                    "inputBinding": {
                        "prefix": "--to-tsv"
                    },
                    "id": "#biom-convert.cwl/tsv"
                }
            ],
            "arguments": [
                {
                    "valueFrom": "${ var ext = \"\";\n   if (inputs.json) { ext = \"_json.biom\"; }\n   if (inputs.hdf5) { ext = \"_hdf5.biom\"; }\n   if (inputs.tsv) { ext = \"_tsv.biom\"; }\n   var pre = inputs.biom.nameroot.split('.');\n   pre.pop()\n   return pre.join('.') + ext; }\n",
                    "prefix": "--output-fp"
                },
                {
                    "valueFrom": "--collapsed-observations"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "${ var ext = \"\";\nif (inputs.json) { ext = \"_json.biom\"; }\nif (inputs.hdf5) { ext = \"_hdf5.biom\"; }\nif (inputs.tsv) { ext = \"_tsv.biom\"; }\nvar pre = inputs.biom.nameroot.split('.');\npre.pop()\nreturn pre.join('.') + ext; }\n"
                    },
                    "id": "#biom-convert.cwl/result"
                }
            ],
            "id": "#biom-convert.cwl",
            "http://schema.org/license": "https://www.apache.org/licenses/LICENSE-2.0",
            "http://schema.org/copyrightHolder": "EMBL - European Bioinformatics Institute"
        },
        {
            "class": "CommandLineTool",
            "hints": [
                {
                    "dockerPull": "aeolic/mapseq2biom:latest",
                    "class": "DockerRequirement"
                }
            ],
            "requirements": [
                {
                    "ramMin": 200,
                    "tmpdirMin": 200,
                    "coresMin": 2,
                    "class": "ResourceRequirement"
                }
            ],
            "inputs": [
                {
                    "type": "string",
                    "label": "label to add to the top of the outfile OTU table",
                    "inputBinding": {
                        "prefix": "--label"
                    },
                    "id": "#mapseq2biom.cwl/label"
                },
                {
                    "type": "File",
                    "doc": "the OTU table produced for the taxonomies found in the reference\ndatabases that was used with MAPseq\n",
                    "inputBinding": {
                        "prefix": "--otuTable"
                    },
                    "id": "#mapseq2biom.cwl/otu_table"
                },
                {
                    "type": "File",
                    "label": "the output from the MAPseq that assigns a taxonomy to a sequence",
                    "inputBinding": {
                        "prefix": "--query"
                    },
                    "id": "#mapseq2biom.cwl/query"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "label": "output NCBI taxids for all databases bar UNITE",
                    "inputBinding": {
                        "prefix": "--taxid"
                    },
                    "id": "#mapseq2biom.cwl/taxid_flag"
                }
            ],
            "baseCommand": [
                "mapseq2biom.pl"
            ],
            "arguments": [
                {
                    "valueFrom": "$(inputs.query.basename).tsv",
                    "prefix": "--outfile"
                },
                {
                    "valueFrom": "$(inputs.query.basename).txt",
                    "prefix": "--krona"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "format": "http://edamontology.org/format_3746",
                    "outputBinding": {
                        "glob": "$(inputs.query.basename).tsv"
                    },
                    "id": "#mapseq2biom.cwl/otu_tsv"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "format": "http://edamontology.org/format_3746",
                    "outputBinding": {
                        "glob": "$(inputs.query.basename).notaxid.tsv"
                    },
                    "id": "#mapseq2biom.cwl/otu_tsv_notaxid"
                },
                {
                    "type": "File",
                    "format": "https://www.iana.org/assignments/media-types/text/tab-separated-values",
                    "outputBinding": {
                        "glob": "$(inputs.query.basename).txt"
                    },
                    "id": "#mapseq2biom.cwl/otu_txt"
                }
            ],
            "id": "#mapseq2biom.cwl",
            "http://schema.org/license": "https://www.apache.org/licenses/LICENSE-2.0",
            "http://schema.org/copyrightHolder": "EMBL - European Bioinformatics Institute"
        },
        {
            "class": "Workflow",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                },
                {
                    "class": "MultipleInputFeatureRequirement"
                },
                {
                    "class": "ScatterFeatureRequirement"
                },
                {
                    "class": "StepInputExpressionRequirement"
                },
                {
                    "class": "SubworkflowFeatureRequirement"
                }
            ],
            "inputs": [
                {
                    "type": "string",
                    "id": "#main/map_label"
                },
                {
                    "type": "File",
                    "id": "#main/map_otu_table"
                },
                {
                    "type": "File",
                    "id": "#main/map_query"
                },
                {
                    "type": "string",
                    "id": "#main/return_dirname"
                }
            ],
            "outputs": [
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "outputSource": "#main/return_output_dir/out",
                    "id": "#main/out_dir"
                }
            ],
            "steps": [
                {
                    "run": "#biom-convert.cwl",
                    "in": [
                        {
                            "source": "#main/mapseq2biom/otu_tsv",
                            "id": "#main/counts_to_hdf5/biom"
                        },
                        {
                            "default": true,
                            "id": "#main/counts_to_hdf5/hdf5"
                        },
                        {
                            "default": "OTU table",
                            "id": "#main/counts_to_hdf5/table_type"
                        }
                    ],
                    "out": [
                        "#main/counts_to_hdf5/result"
                    ],
                    "id": "#main/counts_to_hdf5"
                },
                {
                    "run": "#biom-convert.cwl",
                    "in": [
                        {
                            "source": "#main/mapseq2biom/otu_tsv",
                            "id": "#main/counts_to_json/biom"
                        },
                        {
                            "default": true,
                            "id": "#main/counts_to_json/json"
                        },
                        {
                            "default": "OTU table",
                            "id": "#main/counts_to_json/table_type"
                        }
                    ],
                    "out": [
                        "#main/counts_to_json/result"
                    ],
                    "id": "#main/counts_to_json"
                },
                {
                    "run": "#mapseq2biom.cwl",
                    "in": [
                        {
                            "source": "#main/map_label",
                            "id": "#main/mapseq2biom/label"
                        },
                        {
                            "source": "#main/map_otu_table",
                            "id": "#main/mapseq2biom/otu_table"
                        },
                        {
                            "source": "#main/map_query",
                            "id": "#main/mapseq2biom/query"
                        }
                    ],
                    "out": [
                        "#main/mapseq2biom/otu_tsv",
                        "#main/mapseq2biom/otu_txt",
                        "#main/mapseq2biom/otu_tsv_notaxid"
                    ],
                    "id": "#main/mapseq2biom"
                },
                {
                    "run": "#return_directory.cwl",
                    "in": [
                        {
                            "source": "#main/return_dirname",
                            "id": "#main/return_output_dir/dir_name"
                        },
                        {
                            "source": [
                                "#main/mapseq2biom/otu_tsv",
                                "#main/mapseq2biom/otu_txt",
                                "#main/counts_to_hdf5/result",
                                "#main/counts_to_json/result"
                            ],
                            "id": "#main/return_output_dir/file_list"
                        }
                    ],
                    "out": [
                        "#main/return_output_dir/out"
                    ],
                    "id": "#main/return_output_dir"
                }
            ],
            "id": "#main"
        },
        {
            "class": "ExpressionTool",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                },
                {
                    "class": "MultipleInputFeatureRequirement"
                },
                {
                    "ramMin": 200,
                    "class": "ResourceRequirement"
                },
                {
                    "class": "ScatterFeatureRequirement"
                },
                {
                    "class": "StepInputExpressionRequirement"
                },
                {
                    "class": "SubworkflowFeatureRequirement"
                }
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": [
                                "null",
                                "Directory"
                            ]
                        }
                    ],
                    "id": "#return_directory.cwl/dir_list"
                },
                {
                    "type": "string",
                    "id": "#return_directory.cwl/dir_name"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": [
                                "null",
                                "File"
                            ]
                        }
                    ],
                    "id": "#return_directory.cwl/file_list"
                }
            ],
            "outputs": [
                {
                    "type": "Directory",
                    "id": "#return_directory.cwl/out"
                }
            ],
            "expression": "${\n  var list2 = [];\n  var process;\n  if (inputs.file_list) { process = inputs.file_list } else { process = inputs.dir_list}\n  for (const item in process) {\n      if (process[item] != null) {\n          list2.push(process[item]) }; }\n  return {\"out\": {\n    \"class\": \"Directory\",\n    \"basename\": inputs.dir_name,\n    \"listing\": list2\n    }\n  }; }\n",
            "id": "#return_directory.cwl",
            "http://schema.org/license": "https://www.apache.org/licenses/LICENSE-2.0",
            "http://schema.org/copyrightHolder": "EMBL - European Bioinformatics Institute"
        }
    ],
    "cwlVersion": "v1.0",
    "$schemas": [
        "http://edamontology.org/EDAM_1.16.owl",
        "https://schema.org/version/latest/schemaorg-current-http.rdf"
    ]
}