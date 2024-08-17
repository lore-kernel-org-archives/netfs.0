Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE58653
	for <netfs@lists.linux.dev>; Sat, 17 Aug 2024 08:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723884655; cv=none; b=n+UzZsAdZgjD1r6h7R15gjMV8NFo+D0wEQq6KnHTPEb18WS7PeRVkG1r50HTy4E4CghfNkvWc8bs0tVGSrt9+vJDoIBKNv550/r4B/pyEAC1w5zrg5GR2VZdTLGfrkPQ1Kz43MQCGgMafSI44zcViRDPv2Yhkll2TQzKabsXRtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723884655; c=relaxed/simple;
	bh=F7HBEHKXFO0xpO53ZBEeYIwp3RgZ1ffoQoBDp9NUi2w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K8ucIlfY3G5frdHzXZtjMnHGIBYm2zhxpbQo5UWfemTnXFGBiV01zmBRFG4Q5Gq/FaV7XmUqdMYnFL3x31IBEamvlU8MfsbYf13kiSjk7V5gBDtzEpZLu5b/h8QqIgt1NW5aIQAZpApIGz7Pt2JEMd0w6uV2oahGU1Vy3PTMqKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WmCHZ2g33z4f3jcx
	for <netfs@lists.linux.dev>; Sat, 17 Aug 2024 16:50:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4DB591A0568
	for <netfs@lists.linux.dev>; Sat, 17 Aug 2024 16:50:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCHr4VhZMBmPT66Bw--.39037S4;
	Sat, 17 Aug 2024 16:50:48 +0800 (CST)
From: yangerkun <yangerkun@huaweicloud.com>
To: dhowells@redhat.com,
	brauner@kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	hsiangkao@linux.alibaba.com
Cc: netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2] netfs: fix the mismatch used for CONFIG_FSCACHE_DEBUG
Date: Sat, 17 Aug 2024 16:46:19 +0800
Message-Id: <20240817084619.2075189-1-yangerkun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHr4VhZMBmPT66Bw--.39037S4
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr1DGryUCF1DCF48tFWkZwb_yoWDZrc_tF
	40yF18Xr45tF9aq34xCrWI9FWUWa97KF48uw13trZIqrZxtas5CFsag393AwsxWF4UWrnr
	Awnaqrs8ury7GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267
	AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80
	ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4
	AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

From: yangerkun <yangerkun@huawei.com>

The name of debug config used in fs/netfs/internal.h has a mismatch
compared to the define in fs/netfs/Kconfig, which lead to that debug for
netfs won't work.

Signed-off-by: yangerkun <yangerkun@huawei.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/netfs/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

No logic change, send v2 since this patch does not accept for a long
time...

diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 7773f3d855a9..a683a8505696 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -365,7 +365,7 @@ void fscache_create_volume(struct fscache_volume *volume, bool wait);
 #define _leave(FMT, ...) kleave(FMT, ##__VA_ARGS__)
 #define _debug(FMT, ...) kdebug(FMT, ##__VA_ARGS__)
 
-#elif defined(CONFIG_NETFS_DEBUG)
+#elif defined(CONFIG_FSCACHE_DEBUG)
 #define _enter(FMT, ...)			\
 do {						\
 	if (netfs_debug)			\
-- 
2.39.2

