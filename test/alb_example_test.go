package test

import (
	"fmt"
	"testing"
	"time"

	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAlbExample(t *testing.T) {
	opts := &terraform.Options{
		TerraformDir: "../example/alb",
	}

	// テストの最後にすべてを後片付け
	defer terraform.Destroy(t, opts)

	// サンプルをデプロイ
	terraform.InitAndApply(t, opts)

	// ALBのURLを取得
	albDnsName := terraform.OutputRequired(t, opts, "alb_dns_name")
	url := fmt.Sprintf("http://%s", albDnsName)

	// ALBのデフォルトアクションが動作し、404を返すことをテスト
	expectedStatus := 404
	expectedBody := "404: page not found"
	maxRetries := 10
	timeBetweenRetries := 10 * time.Second

	http_helper.HttpGetWithRetry(
		t,
		url,
		nil,
		expectedStatus,
		expectedBody,
		maxRetries,
		timeBetweenRetries,
	)
}
