include .env
DC=docker-compose
EXEC=$(DC) exec
CONSOLE=$(EXEC) php bin/console
PROJECT_DIR=/symfony
RUN=$(DC) run --rm
RUN_PROJECT=$(RUN) -w $(PROJECT_DIR)
ENV?=dev

##########################################################################

start:          ## Install and start the project
start: config build up db-migrate db-fixtures vendor
up:
	@$(DC) up --build -d --remove-orphans
stop:
	docker-compose kill
build:
	@$(DC) build
down:
	docker-compose down

bash:
	docker-compose exec php bash
mysql:
	$(EXEC) mysql mysql -u"${MYSQL_USER}" -p"${MYSQL_PASSWORD}"

##########################################################################


##
## DB
##---------------------------------------------------------------------------

db-diff:        ## Generation doctrine diff
	@$(CONSOLE) doctrine:migrations:diff --env $(ENV)

db-migrate:     ## Launch doctrine migrations
	@$(CONSOLE) doctrine:migrations:migrate $(VERSION) --no-interaction --env $(ENV)

db-fixtures:    ## Load fixtures
	@$(CONSOLE) doctrine:fixtures:load --no-interaction --env $(ENV)


##
## Configuration
##---------------------------------------------------------------------------

config:         ## Init files required
config: .env docker-compose.override.yml .git/hooks/pre-commit
	@echo 'Configuration files copied'
.env: .env.dist
	@echo "Copying environment variables"
	@cp .env.dist .env

docker-compose.override.yml: docker-compose.override.yml.dist
	@echo "Copying docker configuration"
	@cp docker-compose.override.yml.dist docker-compose.override.yml
vendor: symfony/composer.json
	@echo "Installing app dependencies"
	@$(RUN_PROJECT) php php -d memory_limit=-1 /usr/local/bin/composer install --no-interaction

assets:
	@echo   "assets install"
	@$(CONSOLE) assets:install --symlink

.git/hooks/pre-commit:
	@echo "Copying git hooks"
	@cp docker/git/pre-commit .git/hooks/pre-commit
	@chmod +x .git/hooks/pre-commit