import { ApolloServer } from 'apollo-server'

import { resolverContext, resolvers } from './resolvers'
import { typeDefsList } from './schemas'

const server = new ApolloServer({
  typeDefs: typeDefsList,
  context: resolverContext,
  resolvers,
})

server.listen().then(({ url }) => {
  console.log(`The apollo server is running at ${url}.`)
})
