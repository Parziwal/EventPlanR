using AutoMapper;
using EventPlanr.Domain.Common;

namespace EventPlanr.Application.Models.Common;

public class AddressDto
{
    public string Country { get; set; } = null!;
    public string ZipCode { get; set; } = null!;
    public string City { get; set; } = null!;
    public string AddressLine { get; set; } = null!;

    private class Mapping : Profile
    {
        public Mapping()
        {
            CreateMap<Address, AddressDto>();
        }
    }
}
