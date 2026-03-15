define log_info
	@echo "\033[1;34m[INFO]\033[0m $(1)"
endef

define log_success
	@echo "\033[0;32m[SUCCESS]\033[0m $(1)"
endef

define log_error
	@echo "\033[0;31m[ERROR]\033[0m $(1)"
endef