using EventPlanr.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore.ValueGeneration;

namespace EventPlanr.Infrastructure.Persistance.Configuration;

public class ChatMemberEntityConfiguration : IEntityTypeConfiguration<ChatMemberEntity>
{
    public void Configure(EntityTypeBuilder<ChatMemberEntity> builder)
    {
        builder.ToTable("chat_members");

        builder.Property(o => o.Id)
            .HasValueGenerator<GuidValueGenerator>();

        builder.HasOne(cm => cm.Chat)
            .WithMany(c => c.ChatMembers)
            .HasForeignKey(c => c.ChatId);
    }
}
