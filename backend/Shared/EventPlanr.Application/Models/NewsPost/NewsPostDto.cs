using AutoMapper;
using Entities = EventPlanr.Domain.Entities;

namespace EventPlanr.Application.Models.NewsPost;

public class NewsPostDto
{
    public string Text { get; set; } = null!;
    public DateTimeOffset LastModified { get; set; }

    private class Mapping : Profile
    {
        public Mapping()
        {
            CreateMap<Entities.NewsPost, NewsPostDto>();
        }
    }
}
