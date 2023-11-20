using EventPlanr.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore.ValueGeneration;

namespace EventPlanr.Infrastructure.Persistance.Configuration;

public class InvitationConfiguration : IEntityTypeConfiguration<InvitationEntity>
{
    public void Configure(EntityTypeBuilder<InvitationEntity> builder)
    {
        builder.ToTable("invitations");

        builder.Property(i => i.Id)
            .HasValueGenerator<GuidValueGenerator>();
        builder.Property(i => i.UserId)
            .IsRequired();
        builder.Property(i => i.Status)
            .IsRequired();

        builder.HasOne(i => i.Event)
            .WithMany(e => e.Invitations)
            .HasForeignKey(i => i.EventId)
            .IsRequired();
    }
}
