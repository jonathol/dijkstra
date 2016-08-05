require_relative 'graph'

# O(|V|**2 + |E|).
def dijkstra1(source)
  shortest_paths = {}
  possible_paths = {
    source => {
      cost: 0,
      last_edge: nil
    }
  }

  until possible_paths.empty?
    vertex = possible_paths.min_by{ |vertex,data| data[:cost] } [0]
    shortest_paths[vertex] = possible_paths[vertex]
    possible_paths.delete(vertex)

    path_to_vertex_cost = shortest_paths[vertex][:cost]

    vertex.out_edges.each do |e|
      to_vertex = e.to_vertex
      next if shortest_paths.has_key?(to_vertex)
      extended_path_cost = path_to_vertex_cost + e.cost
      next if possible_paths.has_key?(to_vertex) && possible_paths[to_vertex][:cost] <= extended_path_cost
      possible_paths[to_vertex] = {
        cost: extended_path_cost,
        last_edge: e
      }
    end
  end
  
  shortest_paths
end
