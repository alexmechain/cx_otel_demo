defmodule Featureflagservice.Repo.Migrations.CreateFeatureflags do
  use Ecto.Migration

  def change do
    create table(:featureflags) do
      add :name, :string
      add :description, :string
      add :enabled, :boolean, default: false, null: false

      timestamps()
    end

    create unique_index(:featureflags, [:name])

    execute(&execute_up/0, &execute_down/0)
  end

  defp execute_up do
    repo().insert(%Featureflagservice.FeatureFlags.FeatureFlag{
      name: "productCatalogFailure",
      description: "Fail product catalog service on a specific product",
      enabled: false})
      #@ALM: replace false by true in line above for automatic FF implementation on deployment

    repo().insert(%Featureflagservice.FeatureFlags.FeatureFlag{
      name: "recommendationCache",
      description: "Cache recommendations",
      enabled: false})
      #@ALM: replace 'false' by 'true' in line above for automatic FF implementation on deployment
  end

  defp execute_down do
    repo().delete(%Featureflagservice.FeatureFlags.FeatureFlag{name: "productCatalogFailure"})
    repo().delete(%Featureflagservice.FeatureFlags.FeatureFlag{name: "recommendationCache"})
  end
end
