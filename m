Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795080087;
	b=MQMguSdo5saIsyc/IL4qfPCa/pNWQbdW/xsxqxlqRjtEu0TrHjDoMCWSVlJI3UAW7Z+X
	 F63YBB2s41sN7vFJipk6p9EOuTTYgHmdQ5euldGAnhwc0JH3KmWd6MHZ2F+WAcZnZ2Y++
	 zHP/sSwPjYnS5mvE79q3Y967O3heSy7K7c4FPiU4UlpIRGfW0thgUsd5UcODFASexj7v9
	 GdU4SLBeEHobQMekoqyrX61VsTyp7jC5anWtA3xoE4dJco9DcA6ZXDeZPTUwCYt7irEJ6
	 0WXJlWnoXf/UcdgJCQ/xKPXYz3Ey3k2QOxMDuhargSPXSajneFDe9aIIxOtFcGYKx4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795080087;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=phJmb426aoRooYkR2Gofxf73gCjIrRfzoC/1uf618JI=;
	b=B4JQq3l0A5YTRWQbXA7xLhR9pezLEBAHW9yv+VumWQNjA4aDy1+uwtJvdLeZfwLA1e2d
	 Hsx/GIfm9BkQiJmTpF89dfcTGfXu1cIkAXJRig5BG1oxor2/zyYKWb+O8bGrTJ7amn+9/
	 9K7N29gGP5i1Y1JggZSlQdxdHgTmv7Nn865uvvPqoTdqtozUlfsEkEQF8mN5ULO8CVNk7
	 NaA1qPHr3op3anOrpDLFfHVvBnSJnShcHJLymkXg+OQA2tshUsfMgGKVAVDdT3xK73npA
	 tI66QLqSuoALOpGIds1ztrejjDRCKqNHuiUphWvfi79Dfl1NGuGQIRWZ0h8J0OIPl5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A558C606A320;
	Thu, 19 Nov 2026 09:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A558C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 93cdc67ee3fa11f19a56ed5b684f684d-20261119
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:3e6c968f-f40c-41d1-b7b3-9939313b65b4,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:7db8b62,CLOUDID:6521bea9981703ccd9b9ae390e9a61cd,BulkI
	D:nil,BulkQuantity:0,SF:81|82|83|102|850|865|898,TC:nil,Content:0|15|50|99
	|100|102|153,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 93cdc67ee3fa11f19a56ed5b684f684d-20261119
X-User: wangyibo@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <wangyibo@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 727782934; Thu, 19 Nov 2026 17:21:18 +0800
From: Wang Yibo <wangyibo@kylinos.cn>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>,
	Paulo Alcantara <pc@manguebit.org>,
	Matthew Wilcox <willy@infradead.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Stefan Metzmacher <metze@samba.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v19 01/17] iov_iter: Fix kunit test to remove __init and __refdata marks
Date: Thu, 19 Nov 2026 17:21:15 +0800
Message-Id: <20261119092115.3957212-1-wangyibo@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261119083851.3306418-2-dhowells@redhat.com>
References: <20261119083851.3306418-2-dhowells@redhat.com>
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Post: <mailto:netfs@lists.linux.dev>
List-Help: <mailto:netfs+help@lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:netfs+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi David,

> Remove the __init marks from the functions in the iov_iter kunit test so
> that they don't get removed after the module is loaded or if the test is
> built in as the tests can be triggered through debugfs too.

The reasoning looks right to me.  The suite is registered with
kunit_test_suites(), so it gets a debugfs "run" file and can be re-run
after the init sections have been freed; calling into an __init function
from there is a use-after-free, and __refdata on the case array keeps
modpost from flagging the reference to init text.

There is one more file in the tree with the same problem:

  lib/tests/bitfield_kunit.c:60   __init test_bitfields_constants()
  lib/tests/bitfield_kunit.c:103  __init test_bitfields_variables()
  lib/tests/bitfield_kunit.c:140  __refdata bitfields_test_cases[]
  lib/tests/bitfield_kunit.c:151  kunit_test_suites(&bitfields_test_suite)

(line numbers from v7.4-rc1; test_bitfields_compile() is also marked
__init but is only built under TEST_BITFIELD_COMPILE and is not in the
case array)

I went through the other suites that still have __init case functions --
drivers/char/misc_minor_kunit.c, init/initramfs_test.c,
security/landlock/id.c and lib/kunit/kunit-example-test.c -- and they
are fine: they are all registered with
kunit_test_init_section_suites(), which does not create a "run" file, so
keeping __init there is correct.

Do you want the bitfields one folded into this series, or would you
rather I send it separately?

Thanks,
Wang Yibo
