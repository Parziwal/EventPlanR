using EventPlanr.Domain.Repositories.Models;
using System.Runtime.CompilerServices;

namespace EventPlanr.Application.Mappings;

public static class PaginatedListMapperExtension
{
    public static PaginatedList<Dest> PaginatedListMapper<Src, Dest>(this PaginatedList<Src> list, Func<Src, Dest> itemMapper)
    {
        return new PaginatedList<Dest>()
        {
            Items = list.Items.Select(itemMapper).ToList(),
            PageNumber = list.PageNumber,
            TotalPages = list.TotalPages,
            TotalCount = list.TotalCount,
        };
    }
}
