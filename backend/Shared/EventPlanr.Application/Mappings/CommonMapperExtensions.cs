using EventPlanr.Application.Models.Common;
using EventPlanr.Domain.Common;
using System.Runtime.CompilerServices;

namespace EventPlanr.Application.Mappings;

public static class CommonMapperExtensions
{
    public static Coordinates ToCoordinates(this CoordinatesDto dto) => new Coordinates()
    {
        Latitude = dto.Latitude,
        Longitude = dto.Longitude,
    };
}
