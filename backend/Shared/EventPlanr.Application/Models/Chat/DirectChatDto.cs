﻿using AutoMapper;
using EventPlanr.Application.Models.Common;
using EventPlanr.Domain.Common;
using EventPlanr.Domain.Entities;

namespace EventPlanr.Application.Models.Chat;

public class DirectChatDto
{
    public Guid Id { get; set; }
    public DateTimeOffset LastMessageDate { get; set; }
    public bool HaveUnreadMessages { get; set; }
    public string ContactFirstName { get; set; } = null!;
    public string ContactLastName { get; set; } = null!;
    public string? ProfileImageUrl { get; set; }
}
