# Convert json to ndjson for elastic search

# python json_to_ndjson.py input.json output.ndjson my-index

import json
import argparse

def convert_to_ndjson(input_file, output_file, index_name):
    try:
        with open(input_file, "r") as infile, open(output_file, "w") as outfile:
            data = json.load(infile)  # Load the JSON data
            
            # Ensure the JSON is a list of objects
            if not isinstance(data, list):
                raise ValueError("Input JSON must be a list of objects.")
            
            for doc in data:
                # Write the metadata line for each document
                outfile.write(json.dumps({"index": {"_index": index_name}}) + "\n")
                # Write the actual document
                outfile.write(json.dumps(doc) + "\n")
        
        print(f"Conversion successful! NDJSON saved to: {output_file}")
    except Exception as e:
        print(f"Error: {e}")

def main():
    parser = argparse.ArgumentParser(description="Convert JSON file to NDJSON format for Elasticsearch Bulk API.")
    parser.add_argument("input_file", help="Path to the input JSON file.")
    parser.add_argument("output_file", help="Path to save the NDJSON output file.")
    parser.add_argument("index_name", help="Elasticsearch index name for the NDJSON metadata.")
    
    args = parser.parse_args()
    
    convert_to_ndjson(args.input_file, args.output_file, args.index_name)

if __name__ == "__main__":
    main()