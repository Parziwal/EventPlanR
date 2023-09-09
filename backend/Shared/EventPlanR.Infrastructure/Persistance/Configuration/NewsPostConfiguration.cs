﻿using EventPlanR.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore.ValueGeneration;

namespace EventPlanR.Infrastructure.Persistance.Configuration;

public class NewsPostConfiguration : IEntityTypeConfiguration<NewsPost>
{
    public void Configure(EntityTypeBuilder<NewsPost> builder)
    {
        builder.ToTable("news_posts");

        builder.Property(op => op.Id)
            .HasValueGenerator<GuidValueGenerator>();
        builder.Property(np => np.Text)
            .IsRequired();

        builder.HasOne(np => np.Event)
            .WithMany(e => e.NewsPosts)
            .HasForeignKey(np => np.EventId)
            .IsRequired();
    }
}
