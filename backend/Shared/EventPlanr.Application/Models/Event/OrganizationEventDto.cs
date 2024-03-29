﻿using AutoMapper;
using EventPlanr.Domain.Entities;

namespace EventPlanr.Application.Models.Event;

public class OrganizationEventDto
{
    public Guid Id { get; set; }
    public string Name { get; set; } = null!;
    public string? CoverImageUrl { get; set; }
    public DateTimeOffset FromDate { get; set; }
    public Guid ChatId { get; set; }
    public bool IsPrivate { get; set; }

    private class Mapping : Profile
    {
        public Mapping()
        {
            CreateMap<EventEntity, OrganizationEventDto>();
        }
    }
}
