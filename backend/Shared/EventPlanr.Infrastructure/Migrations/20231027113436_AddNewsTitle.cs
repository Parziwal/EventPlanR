using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace EventPlanr.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class AddNewsTitle : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "Title",
                table: "news_posts",
                type: "character varying(64)",
                maxLength: 64,
                nullable: false,
                defaultValue: "");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Title",
                table: "news_posts");
        }
    }
}
