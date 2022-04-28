import { ApolloServer } from 'apollo-server'

import gameTypeDefs from '../schemas/game'
import queryTypeDefs from '../schemas/query'
import { resolvers } from './index'

const createTestServer = () => {
  return new ApolloServer({
    typeDefs: [gameTypeDefs, queryTypeDefs],
    resolvers
  });
}

describe('Query', () => {
  describe('findGames', () => {
    test('it should return at least one element', async () => {
      const server = createTestServer()
      const result = await server.executeOperation({
        query: 'query { findGames { id } }',
      });
      expect(result.data?.findGames.length).toBeGreaterThanOrEqual(1);
    })
  })
})
