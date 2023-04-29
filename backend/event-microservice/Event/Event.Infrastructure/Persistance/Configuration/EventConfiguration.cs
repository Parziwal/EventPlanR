using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Entites = Event.Domain.Entities;

namespace Event.Infrastructure.Persistance.Configuration;

public class EventConfiguration : IEntityTypeConfiguration<Entites.Event>
{
    public void Configure(EntityTypeBuilder<Entites.Event> builder)
    {
        builder.ToTable("events");

        builder.Property(e => e.Id)
            .HasDefaultValueSql("uuid_generate_v4()");
        builder.Property(e => e.Name)
            .IsRequired()
            .HasMaxLength(64);
        builder.Property(e => e.Category)
            .IsRequired();
        builder.Property(e => e.FromDate)
            .IsRequired();
        builder.Property(e => e.ToDate)
            .IsRequired();
        builder.Property(e => e.Description)
            .HasMaxLength(256);

        var address = builder.OwnsOne(e => e.Address);

        address.Property(ea => ea.Country)
            .HasMaxLength(64)
            .IsRequired();
        address.Property(ea => ea.City)
            .HasMaxLength(64)
            .IsRequired();
        address.Property(ea => ea.AddressLine)
            .HasMaxLength(128)
            .IsRequired();
        address.Property(ea => ea.Location)
            .HasColumnType("geography (point)")
            .IsRequired();
    }
}
