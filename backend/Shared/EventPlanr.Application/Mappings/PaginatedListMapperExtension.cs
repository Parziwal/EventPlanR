using EventPlanr.Application.Dto.Common;
using System.Runtime.CompilerServices;

namespace EventPlanr.Application.Mappings;

public static class PaginatedListMapperExtension
{
    public static PaginatedListDto<Dest> PaginatedListMapper<Src, Dest>(this PaginatedListDto<Src> list, Func<Src, Dest> itemMapper)
    {
        return new PaginatedListDto<Dest>()
        {
            Items = list.Items.Select(itemMapper).ToList(),
            PageNumber = list.PageNumber,
            TotalPages = list.TotalPages,
            TotalCount = list.TotalCount,
        };
    }
}
