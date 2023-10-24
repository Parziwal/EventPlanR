using AutoMapper;
using EventPlanr.Domain.Common;
using NetTopologySuite.Geometries;

namespace EventPlanr.Application.Models.Common;

public class CoordinateDto
{
    public double Latitude { get; set; }
    public double Longitude { get; set; }

    private class Mapping : Profile
    {
        public Mapping()
        {
            CreateMap<Point, CoordinateDto>()
                .ForMember(dest => dest.Latitude, opt => opt.MapFrom(src => src.X))
                .ForMember(dest => dest.Longitude, opt => opt.MapFrom(src => src.Y));
        }
    }
}
