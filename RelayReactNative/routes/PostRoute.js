/**
 * @providesModule routes/PostRoute
 */

import Relay, { Route } from 'react-relay';

export default class PostRoute extends Route {
  static queries = {
    post: () => Relay.QL`
      query {
        post(id: $postID)
      }
    `
  };

  static paramDefinitions = {
    postID: { required: true }
  };

  static routeName = 'PostRoute';
}
