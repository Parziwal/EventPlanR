using AutoMapper;
using EventPlanr.Domain.Entities;

namespace EventPlanr.Application.Models.User;

public class UserDto
{
    public Guid Id { get; set; }
    public string FirstName { get; set; } = null!;
    public string LastName { get; set; } = null!;
    public string Email { get; set; } = null!;

    private class Mapping : Profile
    {
        public Mapping()
        {
            CreateMap<UserEntity, UserDto>();
        }
    }
}
