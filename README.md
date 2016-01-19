# Elasticsearcher

Playtime app to learn about different ways to use Elasticsearch with the `elasticsearch-ruby`
and `elasticsearch-rails` gems.

## Models

* Post(:title, :body)
* Author(:name, :hometown)

## Connecting to Elasticsearch

Elasticsearch's ruby client looks for ELASTICSEARCH_URL to specify where to point queries.
When we run our test server, the test cluster looks for several other environment variables
(see [elasticsearch-extensions gem](https://github.com/elastic/elasticsearch-ruby/blob/master/elasticsearch-extensions/lib/elasticsearch/extensions/test/cluster.rb) for details).  In this app, we leverage

    TEST_CLUSTER_PORT  (in spec/support/test_es_server.rb)
    TEST_CLUSTER_LOGS  (in circle.yml)

Note, that even after setting the TEST_CLUSTER_PORT for the test cluster, this does *NOT* set the proper port for
the Elasticsearch::Client which is automagically hooked to ActiveRecord::Base models - assuming the highest level
integration (`include Elasticsearch::Model`).  So don't forget to set ELASTICSEARCH_URL for test to match the
lTEST_CLUSTER_PORT (whose default is 9250).  Check the `.env` and `.env.test` files included in this project.

Generated with [Raygun](https://github.com/carbonfive/raygun).

# Development

## Getting Started

### Requirements

To run the specs or fire up the server, be sure you have these installed (and running):

* Ruby 2.3 (see [.ruby-version](.ruby-version)).
* PostgreSQL 9.x (```brew install postgresql```) with superuser 'postgres' with no password
  (```createuser -s postgres```).
* PhantomJS for Capybara and Javascript testing (```brew install phantomjs```).
* Elasticsearch >= 2.0.x for testing (```brew install elasticsearch```).

### First Time Setup

After cloning, run [./bin/setup](bin/setup) to install missing gems and prepare the database.

Note, ```rake db:sample_data``` loads a small set of data for development. Check out
[db/sample_data.rb](db/sample_data.rb) for details.

### Running the Specs

To run all Ruby and Javascript specs.

    $ ./bin/rake

Note: ```./bin/rake``` runs the springified version of rake (there's a ```./bin/rspec``` and ```./bin/rails``` too). You
can add ```./bin``` to your PATH too, then you'll always use the springified bins when they exist. See
[rails/spring](https://github.com/rails/spring) for additional information.

### Running the Application Locally

    $ foreman start
    $ open http://localhost:3000

## Conventions

### Git

* Branch ```development``` is auto-deployed to acceptance.
* Branch ```master``` is auto-deployed to production.
* Create feature branches off of ```development``` using the naming convention
  ```(features|chores|bugs)/a-brief-description-######```, where ###### is the tracker id.
* Rebase your branch before merging into ```development``` to produce clean merge bubbles.
* Retain merge commits for multi-commit branches when merging into ```development``` (e.g.
  ```git merge --no-ff branchname```).
* Craft atomic commits that make sense on their own and can be easily cherry-picked or reverted if necessary.

### Code Style

Generally speaking, follow the [Ruby Style Guide](https://github.com/bbatsov/ruby-style-guide). Additionally, these are
other guidelines adopted by the team:

**Always use double quotes for test/spec descriptions, unless the subject is a class/module.**

```ruby
describe SomeController do
  context "when logged in as an admin" do
    describe "#some_method" do
      it "does some thing"
    end
  end
end
````

## Additional/Optional Development Details

### Code Coverage (local)

Coverage for the ruby specs:

    $ COVERAGE=true rspec

Code coverage is reported to Code Climate on every CI build so there's a record of trending.

### Using Guard

Guard is configured to run ruby and jasmine specs, and also listen for livereload connections.

    $ bundle exec guard

### Using Mailcatcher

    $ gem install mailcatcher
    $ mailcatcher
    $ open http://localhost:1080/

Learn more at [mailcatcher.me](http://mailcatcher.me/). And please don't add mailcatcher to the Gemfile.

### Continuous Integration and Deployment with CircleCI

This project is configured for continuous integration and deployment with CircleCI and Heroku.

Check out [circle.yml](circle.yml) and [bin/deploy.sh](bin/deploy.sh) for details.

# Server Environments

### Hosting

Acceptance and Production are hosted on Heroku under the _email@example.com_ account.

### Environment Variables

Several common features and operational parameters can be set using environment variables.

**Required**

* ```SECRET_KEY_BASE``` - Secret key base for verfying signed cookies. Should be 30+ random characters and secret!

**Optional**

* ```HOSTNAME``` - Canonical hostname for this application. Other incoming requests will be redirected to this hostname.
* ```BASIC_AUTH_PASSWORD``` - Enable basic auth with this password.
* ```BASIC_AUTH_USER``` - Set a basic auth username (not required, password enables basic auth).
* ```PORT``` - Port to listen on (default: 3000).
* ```PUMA_WORKERS``` - Number of puma workers to spawn (default: 1).
* ```MIN_THREADS``` - Minimum threads per worker (default: 8).
* ```MAX_THREADS``` - Maximum threads per worker (default: 16).
* ```DB_POOL``` - Number of DB connections per pool (i.e. per worker) (default: MAX_THREADS or 5).

### Third Party Services

* Heroku for hosting.
* CircleCI for continuous integration and deployment.
