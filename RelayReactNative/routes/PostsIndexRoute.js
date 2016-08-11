/**
 * @providesModule routes/PostsIndexRoute
 */

import Relay, { Route } from 'react-relay';

export default class PostsIndexRoute extends Route {
  static queries = {
    posts: () => Relay.QL`query { posts }`
  };

  static routeName = 'PostsIndexRoute';
}
