import { StaticDataSources, staticDataSources } from '../data-sources'
import { Resolvers } from '../generated/graphql'

type ResolverContext = {
  readonly staticDataSources: StaticDataSources
}

export const resolverContext: ResolverContext = {
  staticDataSources,
}

export const resolvers: Resolvers<ResolverContext> = {
  Query: {
    findGames: (_parent, _args, context) => {
      return context.staticDataSources.games.slice()
    },
  },
}
