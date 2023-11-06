using AutoMapper;
using EventPlanr.Domain.Entities;

namespace EventPlanr.Application.Models.User;

public class UserDto
{
    public Guid Id { get; set; }
    public string FirstName { get; set; } = null!;
    public string LastName { get; set; } = null!;
    public string Email { get; set; } = null!;
    public string? ProfileImageUrl { get; set; }

    private class Mapping : Profile
    {
        public Mapping()
        {
            CreateMap<UserEntity, UserDto>()
                .ForMember(dest => dest.ProfileImageUrl, opt => opt.MapFrom(src => src.Picture));
        }
    }
}
