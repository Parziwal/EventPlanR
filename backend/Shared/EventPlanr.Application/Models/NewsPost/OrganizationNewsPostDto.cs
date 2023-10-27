using AutoMapper;
using EventPlanr.Application.Models.Common;
using EventPlanr.Domain.Entities;

namespace EventPlanr.Application.Models.NewsPost;

public class OrganizationNewsPostDto : BaseAuditableDto
{
    public Guid Id { get; set; }
    public string Title { get; set; } = null!;
    public string Text { get; set; } = null!;

    private class Mapping : Profile
    {
        public Mapping()
        {
            CreateMap<NewsPostEntity, OrganizationNewsPostDto>();
        }
    }
}
