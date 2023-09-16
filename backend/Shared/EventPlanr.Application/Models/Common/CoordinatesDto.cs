using AutoMapper;
using EventPlanr.Domain.Common;

namespace EventPlanr.Application.Models.Common;

public class CoordinatesDto
{
    public double Latitude { get; set; }
    public double Longitude { get; set; }

    private class Mapping : Profile
    {
        public Mapping()
        {
            CreateMap<Coordinates, CoordinatesDto>();
        }
    }
}
