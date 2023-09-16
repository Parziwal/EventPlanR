﻿using EventPlanr.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore.ValueGeneration;

namespace EventPlanr.Infrastructure.Persistance.Configuration
{
    public class OrganizationConfiguration : IEntityTypeConfiguration<Organization>
    {
        public void Configure(EntityTypeBuilder<Organization> builder)
        {
            builder.ToTable("organizations");

            builder.Property(o => o.Id)
                .HasValueGenerator<GuidValueGenerator>();
            builder.Property(o => o.Name)
                .HasMaxLength(64)
                .IsRequired();
            builder.Property(o => o.Description)
                .HasMaxLength(256);
        }
    }
}
