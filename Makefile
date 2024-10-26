# Define the path to the raw data file. This variable can be reused in commands below.
RAW_DATA_PATH = raw_data/WHR2023.csv

# Define the path to the processed data file. Also reused in the commands.
PROCESSED_DATA = processed_data/WHR2023_cleaned.csv

# The 'install' target installs necessary packages.
# - Upgrades pip to the latest version.
# - Installs all Python packages listed in requirements.txt.
install:
	@pip install --upgrade pip && \
	pip install -r requirements.txt

# The 'format' target formats Python code using 'black'.
# - Applies formatting to all `.py` files in the directory.
# - Sets line length to 88 characters.
format:
	python -m black *.py --line-length 88

# The 'process' target runs a data processing script.
# - Takes $(RAW_DATA_PATH) as input (defined above).
# - Calls `data_processing.py` with RAW_DATA_PATH as an argument.
process: $(RAW_DATA_PATH)
	@python data_processing.py $(RAW_DATA_PATH)

# The 'analyze' target runs a data analysis script.
# - Takes $(PROCESSED_DATA) as input (defined above).
# - Calls `data_analysis.py` with PROCESSED_DATA as an argument.
analyze: $(PROCESSED_DATA)
	@python data_analysis.py $(PROCESSED_DATA)

# The 'clean' target removes all processed data files and any PNG files.
# - `rm -rf` deletes files in `processed_data/` and any PNGs in subdirectories.
clean:
	@rm -rf processed_data/* **/*.png

# The 'all' target runs all other targets in sequence.
# - It performs install, format, process, and analyze tasks in order.
all: install format process analyze
