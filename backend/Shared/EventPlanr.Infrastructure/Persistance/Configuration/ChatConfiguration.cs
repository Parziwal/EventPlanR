using EventPlanr.Domain.Entities;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore.ValueGeneration;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Infrastructure.Persistance.Configuration;
public class ChatConfiguration : IEntityTypeConfiguration<ChatEntity>
{
    public void Configure(EntityTypeBuilder<ChatEntity> builder)
    {
        builder.ToTable("chats");

        builder.Property(o => o.Id)
            .HasValueGenerator<GuidValueGenerator>();
    }
}
