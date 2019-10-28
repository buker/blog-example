FROM jekyll/jekyll

COPY --chown=jekyll:jekyll Gemfile .
COPY --chown=jekyll:jekyll Gemfile.lock .

RUN bundle install --quiet --clean
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT /entrypoint.sh
