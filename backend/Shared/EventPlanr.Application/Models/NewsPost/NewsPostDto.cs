﻿using AutoMapper;
using EventPlanr.Domain.Entities;

namespace EventPlanr.Application.Models.NewsPost;

public class NewsPostDto
{
    public Guid Id { get; set; }
    public string Title { get; set; } = null!;
    public string Text { get; set; } = null!;
    public DateTimeOffset LastModified { get; set; }

    private class Mapping : Profile
    {
        public Mapping()
        {
            CreateMap<NewsPostEntity, NewsPostDto>();
        }
    }
}
