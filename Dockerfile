FROM jekyll/jekyll

COPY --chown=jekyll:jekyll Gemfile .
#COPY --chown=jekyll:jekyll Gemfile.lock .
#RUN gem install bundler:1.17.3
RUN gem install bundler
RUN bundle config set clean 'true'
RUN bundle install --quiet

CMD ["jekyll", "serve"]