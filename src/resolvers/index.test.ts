import { ApolloServer } from 'apollo-server'

import { typeDefsList } from '../schemas'
import { resolverContext, resolvers } from './index'

const createTestServer = () => {
  return new ApolloServer({
    typeDefs: typeDefsList,
    context: resolverContext,
    resolvers,
  })
}

describe('Query', () => {
  describe('findGames', () => {
    test('it should return at least one element', async () => {
      const server = createTestServer()
      const result = await server.executeOperation({
        query: 'query { findGames { id } }',
      })
      expect(result.data?.findGames.length).toBeGreaterThanOrEqual(1)
    })
  })
})
