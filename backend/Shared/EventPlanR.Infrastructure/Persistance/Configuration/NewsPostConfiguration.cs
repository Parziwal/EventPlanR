using EventPlanr.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore.ValueGeneration;

namespace EventPlanr.Infrastructure.Persistance.Configuration;

public class NewsPostConfiguration : IEntityTypeConfiguration<NewsPostEntity>
{
    public void Configure(EntityTypeBuilder<NewsPostEntity> builder)
    {
        builder.ToTable("news_posts");

        builder.Property(op => op.Id)
            .HasValueGenerator<GuidValueGenerator>();
        builder.Property(np => np.Title)
            .IsRequired()
            .HasMaxLength(64);
        builder.Property(np => np.Text)
            .IsRequired();

        builder.HasOne(np => np.Event)
            .WithMany(e => e.NewsPosts)
            .HasForeignKey(np => np.EventId)
            .IsRequired(false);
    }
}
